from abc import ABC, abstractmethod
import logging
import datetime

class DatabaseAccessor(ABC):
    @abstractmethod
    def __init__(self, logger):
        self._logger = logger

    @property
    def _log(self):
        return self._logger

    @abstractmethod
    def open(self):
        pass

    @abstractmethod
    def close(self):
        pass

    def __enter__(self):
        self._log.debug("Executing DatabaseAccessor::__enter__()")
        self.open()
        return self

    def __exit__(self, type, value, traceback):
        self._log.debug("Executing DatabaseAccessor::__exit__()")
        self.close()

    @abstractmethod
    def insertMeasurement(self, timestamp: int, sensorName: str, sensorValue: float):
        pass

    @abstractmethod
    def getLastDeviceTimestamp(self) -> datetime.datetime:
        pass
    