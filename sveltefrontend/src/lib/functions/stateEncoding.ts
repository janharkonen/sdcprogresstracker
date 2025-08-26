
export const defaultState : string = "0";

export function increaseState(oldProgressState: string, row: number, column: number, colCount: number) {
    const stateIndex = (column+colCount*row);
    const newState = (Number(oldProgressState) + 1) % 4;
    return newState.toString();
}

export function getState(progressState: string, row: number, column: number, colCount: number) {
    const stateIndex = (column+colCount*row);
    console.log("stateIndex", stateIndex);
    const hexIndex = Math.floor(stateIndex / 2);
    const hexValue = progressState[hexIndex];
    return hexValue === "0" ?  1 : 0;
}




