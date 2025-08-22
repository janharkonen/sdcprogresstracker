import { z } from "zod";
import { query } from "$app/server";
import { Redis } from "ioredis"

const redis = new Redis({
    port: 6379,
    host: 'rediscontainer'
})

export const getSongList = query(z.string(), async (collection: string) => {
    console.log("in server")
    let songList = []
    const keys = await redis.keys(`${collection}:*`)
    keys.sort((a, b) => {
        const numA = parseInt(a.split(':')[1])
        const numB = parseInt(b.split(':')[1])
        return numA - numB
    })
    console.log(keys)
    for (const key of keys) {
        console.log(key)
        const value = await redis.get(key)
        songList.push(value)
    }
    return songList
})

export const getProgressState = query(z.string(), async (group: string) => {
    console.log("in server2")
    const value = await redis.get(`${group}:progress_state`)
    if (value) {
        return value
    } else {
        const defaultState = 0x0n; // Using hexadecimal notation with BigInt
        await redis.set(`${group}:progress_state`, String(defaultState))
        return defaultState
    }
})