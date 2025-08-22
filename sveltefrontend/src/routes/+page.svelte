<script lang="ts">
    import { getProgressState, getSongList } from "./data.remote";
    import { onMount } from "svelte";
    import Table from "$lib/components/table.svelte";

    let count = $state(0);
    let socket: WebSocket | null = $state(null);
    let songlist = $derived(getSongList("taitomerkki") ?? []);
    let progressState = $derived(getProgressState("sdc"));

    function handleClick() {
        console.log("old count", count);
        count = (count + 1) & 0b11;
        console.log("new count", count);
    }

    onMount(() => {
        console.log(window.location.host);
        if (window.location.protocol === "https:") {
            socket = new WebSocket(`wss://${window.location.host}/ws`);
        } else {
            socket = new WebSocket(`ws://${window.location.host}/ws`);
        }

        socket.onmessage = (event) => {
            console.log("message", event.data);
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

<div class="w-full h-full bg-yellow-100 flex justify-center items-center">
    <Table songlist={songlist.current ?? []} progressState={progressState.current ?? ""} />
</div>
<h1>This is progress state: {progressState.current}</h1>

{#if socket}
    <h1>Socket: {socket.readyState}</h1>
{:else}
    <h1>No socket</h1>
{/if}

<button onclick={handleClick}>{count}</button>
