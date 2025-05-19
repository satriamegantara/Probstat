FROM python:3.11-slim

# Install distutils and dependencies
RUN apt-get update && apt-get install -y python3-distutils build-essential

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install dependencies
RUN pip install --upgrade pip setuptools
RUN pip install -r requirements.txt

# Expose port if needed
EXPOSE 8000

# Run your app
CMD ["python", "app.py"]
