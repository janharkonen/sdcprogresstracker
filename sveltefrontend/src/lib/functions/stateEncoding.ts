
export const defaultState : string = "0";

export function increaseState(oldProgressState: string, position: number) {
    const bigInt = BigInt("0x" + oldProgressState);
    const bitShift = 2n * BigInt(position);
    const oldState = (bigInt >> bitShift) & 0b11n;
    const newState = (oldState + 1n) & 0b11n;
    const mask = 0b11n << bitShift;
    const newProgressState = (bigInt & ~mask) | (newState << bitShift);
    return newProgressState.toString(16);
}

export function getState(progressState: string, position: number) {
    const remainder = position % 2;
    const hexIndex = (position - remainder) / 2;
    const strIndex = progressState.length - hexIndex - 1;
    const hexString = progressState[strIndex];
    const hexValue = parseInt(hexString, 16);
    if (remainder === 0) {
        return (hexValue & 0b11).toString();
    } else {
        return (hexValue >> 2).toString();
    }
}




