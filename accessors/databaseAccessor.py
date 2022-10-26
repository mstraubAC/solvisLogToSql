from abc import ABC, abstractmethod

class DatabaseAccessor(ABC):
    @abstractmethod
    def insertMeasurement(self, timestamp: int, sensorName: str, sensorValue: float):
        pass

    @abstractmethod
    def getLastDeviceTimestamp(self):
        pass

    