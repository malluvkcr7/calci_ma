FROM python:3.11-slim
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# default command runs interactive CLI. For CI, we'll run tests separately.
CMD ["python", "calculator.py"]
