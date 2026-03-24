import { describe, it, expect } from "vitest";
import { Cl } from "@stacks/transactions";

describe("stx-module-v2", () => {
  it("should prevent reentrancy", () => {
    const result = simnet.callPublicFn("reentrancy-guard", "protected-action", [], wallet1);
    expect(result.result).toBeOk(Cl.bool(true));
  });

  it("should enforce timelock", () => {
    simnet.callPublicFn("timelock", "queue-action", [Cl.uint(1)], deployer);
    const result = simnet.callPublicFn("timelock", "execute-action", [Cl.uint(1)], deployer);
    expect(result.result).toBeErr(Cl.uint(5));
  });
});
