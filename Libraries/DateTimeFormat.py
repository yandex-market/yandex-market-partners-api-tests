from datetime import datetime


def convert_time(time: str) -> str:
    dt = datetime.strptime(time, '%Y-%m-%d %H:%M:%S')
    return dt.strftime("%Y-%m-%dT%H:%M:%S+03:00")
