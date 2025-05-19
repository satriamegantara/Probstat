FROM python:3.9-slim

WORKDIR /app

# Install system dependencies including distutils
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    python3-distutils \  # Paket penting untuk distutils
    && rm -rf /var/lib/apt/lists/*

# Pastikan pip up-to-date
RUN python -m ensurepip --upgrade

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Set environment variable
ENV FLASK_APP=app.py

# Run the application
CMD ["gunicorn", "--bind", "0.0.0.0:$PORT", "app:app"]
