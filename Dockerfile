FROM python:3.8

RUN pip install pandas

ENTRYPOINT ["python"]