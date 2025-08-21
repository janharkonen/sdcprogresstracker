import { z } from "zod";
import { query } from "$app/server";
import { Redis } from "ioredis"

const redis = new Redis({
    port: 6379,
    host: 'rediscontainer'
})

export const getState = query(z.string(), async () => {
    console.log("in server")
    let songList = []
    const keys = await redis.keys('taitomerkki:*')
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