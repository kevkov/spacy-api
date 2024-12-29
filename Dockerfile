# Use the latest Python base image
FROM python:3.12-slim

# Set environment variables to not generate .pyc files and ensure stdout is flushed
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory inside the container
WORKDIR /app

# Copy requirements early to take advantage of Docker caching
COPY requirements.txt /app/

# Install dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    python -m spacy download en_core_web_lg

# Copy the rest of your application code
COPY . /app/

# Expose the port FastAPI will run on
EXPOSE 8000

# Set default command to run the FastAPI application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]