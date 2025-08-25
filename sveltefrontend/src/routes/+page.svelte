<script lang="ts">
    import { getProgressState, getSongList } from "./data.remote";
    import { onMount } from "svelte";
    import Table from "$lib/components/table.svelte";

    let count = $state(0);
    let socket: WebSocket | null = $state(null);
    
    let songlist = $state<string[]>([]);
    getSongList("taitomerkki").then((v) => {
        songlist = v ?? [];
    });
    
    let progressState = $state(0n);
    getProgressState("sdc").then((v) => {
        progressState = BigInt(v ?? 0n);
    });

    $inspect("progressState", progressState);
    $inspect("songlist", songlist);


    function handleClick(socket: WebSocket | null, newState: BigInt) {
        if (socket) {
            console.log("clicked in frontend", newState);
            socket.send(newState.toString());
        }
    }

    onMount(() => {
        console.log(window.location.host);
        if (window.location.protocol === "https:") {
            socket = new WebSocket(`wss://${window.location.host}/ws`);
        } else {
            socket = new WebSocket(`ws://${window.location.host}/ws`);
        }

        socket.onmessage = (event) => {
            console.log("asd message", event.data);
            progressState = BigInt(event.data);
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

{#if progressState !== null}
    <button onclick={() => handleClick(socket, 124n)} class="w-full h-full bg-yellow-100 flex justify-center items-center">
        {progressState}
    </button>
{/if}
<div class="w-full h-full bg-yellow-100 flex justify-center items-center">
    <Table 
        songlist={songlist} 
        progressState={progressState} 
    />
</div>
