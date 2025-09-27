FROM python:3.11-slim
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Expose port for web interface
EXPOSE 8080

# Run web interface by default, with fallback to CLI
CMD ["python", "-u", "web_calculator.py"]
