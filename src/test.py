import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

@cocotb.test()
async def test_my_design(dut):

    CONSTANT_CURRENT = 40
    dut._log.info("start")

    clock = Clock(dut.clk, 1, units='ns')
    cocotb.start_soon(clock.start())

    dut.rst_n.value = 0 #low to reset
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1 #reset now!

    dut.ui_in.value = CONSTANT_CURRENT
    dut.ena.value = 1 #enable design

    for _ in range(100):
        await RisingEdge(dut.clk)

    dut._log.info("finish")
