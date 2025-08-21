<script lang="ts">
    import { getState } from "./data.remote";
    import { onMount } from "svelte";

    let count = $state(0);
    let socket: WebSocket | null = $state(null);
    let serverdata = $derived(getState(123));

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

<h1>Testing deployment 123 change38</h1>
<h1>This is from the server: {serverdata.current?.count}</h1>

{#if socket}
    <h1>Socket: {socket.readyState}</h1>
{:else}
    <h1>No socket</h1>
{/if}

<button onclick={handleClick}>{count}</button>