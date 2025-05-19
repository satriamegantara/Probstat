FROM python:3.12-slim

# Pastikan dependencies dasar tersedia (termasuk untuk build tools)
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    python3-pip \
    python3-venv \
    python3-dev \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install distutils untuk Python 3.12 (sekarang terpisah di PyPI)
RUN pip install setuptools wheel build

# (opsional) salin file dan jalankan install
WORKDIR /app
COPY . .

# Gunakan build system modern
RUN pip install .

CMD ["python"]
