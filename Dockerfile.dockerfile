FROM python:3.9-slim

WORKDIR /app

# Install dependensi sistem yang diperlukan
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install dependensi Python
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy seluruh aplikasi
COPY . .

# Jalankan aplikasi dengan Gunicorn
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:$PORT"]
