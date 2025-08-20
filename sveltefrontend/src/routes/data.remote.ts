import { z } from "zod";
import { query } from "$app/server";

let serverVariable = 124

export const getState = query(z.number(),async () => {
    console.log("in server")
    serverVariable += 1
    return {
        count: serverVariable
    }
})