import { describe, it, expect } from "vitest";
import { increaseState, getState } from "$lib/functions/stateEncoding"; // or "$lib/stateEncodings"

describe("stateEncodings", () => {
  it("round-trips simple objects", () => {
    const progressState = "5";
    const row = 0;
    const column = 0;
    const colCount = 4;
    const s = getState(progressState, row, column, colCount);
    expect(s).toEqual("1");
  });
});