#sensors k10temp-pci-00c3 amdgpu-pci-0300 | grep -e Tctl -e fan1 -e mem -e junction

from subprocess import check_output as runShellCommand
from re import search
from time import sleep

def checkSensor(sensor, grepstring):
  command = f"sensors {sensor} | grep -e {grepstring}"
  stdout = runShellCommand(command, shell=True, text=True)
  match = search(r"\+[\d\.]+°C", stdout)
  if match:
     return match.group()
  raise f"Could not read {sensor}"

cpuSensorName = "k10temp-pci-00c3"
gpuSensorName = "amdgpu-pci-0300"

while(1):
  cputemp = checkSensor(cpuSensorName, "Tctl")
  gpumemtemp = checkSensor(gpuSensorName, "mem")
  gpujunctiontemp = checkSensor(gpuSensorName, "junction")
  print(f"CPU: {cputemp}\nGPU Memory: {gpumemtemp}\nGPU Junction: {gpujunctiontemp}")
  print("------------------")
  sleep(2)


