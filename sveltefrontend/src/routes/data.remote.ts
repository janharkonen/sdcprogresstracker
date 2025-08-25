import { z } from "zod";
import { query } from "$app/server";
import { Redis } from "ioredis"

const redis = new Redis({
    port: 6379,
    host: 'rediscontainer'
})

// collection = taitomerkki, perusmerkki yms.
export const getSongList = query(z.string(), async (collection: string) => {
    console.log("in server")
    let songList: string[] = []
    const keys = await redis.keys(`${collection}:*`)
    keys.sort((a, b) => {
        const numA = parseInt(a.split(':')[1])
        const numB = parseInt(b.split(':')[1])
        return numA - numB
    })
    for (const key of keys) {
        const value = await redis.get(key)
        if (value !== null) {
            songList.push(value)
        }
    }
    return songList
})

// group = sdc, gch yms.
export const getProgressState = query(z.string(), async (group: string) => {
    const value = await redis.get(`state:${group}`)
    if (value !== null) {
        console.log("++-----------------------------redis value", value);
        return BigInt(value)
    } else {
        const defaultState = 0x0n; // Using hexadecimal notation with BigInt
        redis.set(`state:${group}`, String(defaultState))
        return defaultState
    }
})