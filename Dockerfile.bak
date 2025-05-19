# Gunakan image Python untuk Windows kompatibel
FROM python:3.10-windowsservercore-ltsc2022

WORKDIR C:\\app

# Install system dependencies (jika diperlukan)
RUN pip install --upgrade pip

# Copy requirements
COPY requirements.txt .

# Install Python packages
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV FLASK_APP=app.py
ENV FLASK_ENV=production
EXPOSE 5000

CMD ["waitress-serve", "--port=$PORT", "app:app"]
