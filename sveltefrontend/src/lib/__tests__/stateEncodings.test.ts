import { describe, it, expect } from "vitest";
import { increaseState, getState } from "$lib/functions/stateEncoding"; // or "$lib/stateEncodings"

describe("stateEncodings", () => {
  it("getState1", () => expect(getState("5", 0)).toEqual("1") );
  it("getState2", () => expect(getState("c", 0)).toEqual("0") );
  it("getState3", () => expect(getState("c", 1)).toEqual("3") );
  it("getState4", () => expect(getState("af456c", 1)).toEqual("3") );
  it("getState5", () => expect(getState("af456c", 2)).toEqual("2") );
  it("getState6", () => expect(getState("af456c", 3)).toEqual("1") );
  it("getState7", () => expect(getState("af456c", 4)).toEqual("1") );
  it("getState8", () => expect(getState("af456c", 5)).toEqual("1") );
  it("getState9", () => expect(getState("faf456c", 10)).toEqual("2") );
  
  it("increaseState1", () => expect(increaseState("5", 0)).toEqual("6") );
  it("increaseState2", () => expect(increaseState("7", 0)).toEqual("4") );
  it("increaseState3", () => expect(increaseState("c", 0)).toEqual("d") );
  it("increaseState4", () => expect(increaseState("c", 1)).toEqual("0") );
  it("increaseState5", () => expect(increaseState("b", 1)).toEqual("f") );
  it("increaseState5", () => expect(increaseState("f", 1)).toEqual("3") );
  it("increaseState6", () => expect(increaseState("af456c", 1)).toEqual("af4560") );
  it("increaseState7", () => expect(increaseState("af456c", 2)).toEqual("af457c") );
  it("increaseState8", () => expect(increaseState("af456c", 6)).toEqual("af556c") );
  it("increaseState9", () => expect(increaseState("af456c", 20)).toEqual("10000af456c") );
  it("increaseState9", () => expect(increaseState("af456c", 21)).toEqual("40000af456c") );
  it("increaseState9", () => expect(increaseState("40000af456c", 22)).toEqual("140000af456c") );
});