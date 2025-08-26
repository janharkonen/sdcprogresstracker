<script lang="ts">
    import { getProgressState, getSongList, getSingerList } from "./data.remote";
    import { onMount } from "svelte";
    import { Table, defaultState } from "$lib";

    let count = $state(0);
    let socket: WebSocket | null = $state(null);
    let socketStatus = $state<number>(WebSocket.CONNECTING);
    
    let songlist = $state<string[]>([]);
    getSongList("taitomerkki").then((v) => {
        songlist = v ?? [];
    });
    
    let singerlist = $state<string[]>([]);
    getSingerList("sdc").then((v) => {
        singerlist = v ?? [];
    });
    
    let progressState = $state(defaultState);
    getProgressState("sdc").then((v) => {
        progressState = v ?? defaultState;
    });

    $inspect("progressState", progressState);
    $inspect("songlist", songlist);


    function handleClick(socket: WebSocket | null, progressState: string) {
        if (socket) {
            const stateBigInt = BigInt("0x" + progressState);
            const newStateBigInt = stateBigInt + 1n;
            progressState = newStateBigInt.toString(16);
            socket.send(progressState);
        }
    }

    onMount(() => {
        socketStatus = WebSocket.CONNECTING;
        if (window.location.protocol === "https:") {
            socket = new WebSocket(`wss://${window.location.host}/ws`);
        } else {
            socket = new WebSocket(`ws://${window.location.host}/ws`);
        }

        socket.onmessage = (event) => {
            try {
                progressState = event.data;
            } catch (error) {
                //pass
            }
        }

        socket.onerror = (event) => {
            socketStatus = WebSocket.CLOSED;
        }

        socket.onclose = () => {
            socketStatus = WebSocket.CLOSING;
            socketStatus = WebSocket.CLOSED;
        }
        socket.onopen = () => {
            socketStatus = WebSocket.OPEN;
        }

    });
    

</script>

<style>
    button {
        background-color: #4CAF50;
        border: none;
        color: white;
        padding: 15px 32px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        transition: background-color 0.3s;
    }

    button:hover {
        background-color: #45a049;
    }
</style>

{#if socket}
    {#if socketStatus === WebSocket.OPEN}
        <div class="w-full h-full bg-yellow-100 flex justify-center items-center">
            <Table 
                songlist={songlist} 
                singerlist={singerlist}
                progressState={progressState} 
                socket={socket}
            />
        </div>
    {:else if socketStatus === WebSocket.CONNECTING}
        <div class="w-full h-full bg-yellow-100 flex justify-center items-center">
            <p>Connecting...</p>
        </div>
    {:else if socketStatus === WebSocket.CLOSED}
        <div class="w-full h-full bg-yellow-100 flex justify-center items-center">
            <p>Disconnected</p>
        </div>
    {:else if socketStatus === WebSocket.CLOSING}
        <div class="w-full h-full bg-yellow-100 flex justify-center items-center">
            <p>Closing...</p>
        </div>
    {/if}
{/if}