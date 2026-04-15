# Fixed Dockerfile with HEALTHCHECK instruction
FROM python:3.8-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

HEALTHCHECK CMD ["/bin/bash", "-c", "curl -f http://localhost:5000/ || exit 1"]

CMD ["python", "app.py"]