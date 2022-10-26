from abc import ABC, abstractmethod
import logging
import datetime

class DatabaseAccessor(ABC):
    @abstractmethod
    def open(self):
        pass

    @abstractmethod
    def close(self):
        pass

    def __enter__(self):
        logging.debug("Executing DatabaseAccessor::__enter__()")
        self.open()
        return self

    def __exit__(self, type, value, traceback):
        logging.debug("Executing DatabaseAccessor::__exit__()")
        self.close()

    @abstractmethod
    def insertMeasurement(self, timestamp: int, sensorName: str, sensorValue: float):
        pass

    @abstractmethod
    def getLastDeviceTimestamp(self) -> datetime.datetime:
        pass
    