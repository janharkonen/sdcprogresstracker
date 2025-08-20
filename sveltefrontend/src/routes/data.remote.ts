import { z } from "zod";
import { query } from "$app/server";

export const getState = query(z.number(),async () => {
    console.log("in server")
    return {
        count: 123
    }
})