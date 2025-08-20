<script lang="ts">
    import { getState } from "./data.remote";
    console.log("Testing deployment 1243");

    let count = $state(0);

    let serverdata = $derived(getState(123));

    function handleClick() {
        console.log("old count", count);
        count = (count + 1) & 0b11;
        console.log("new count", count);
    }

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
<button onclick={handleClick}>{count}</button>