FROM --platform=linux/amd64 python:3.8-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Command to run the application using uvicorn
CMD ["uvicorn", "src.mypackage.main:app", "--host", "0.0.0.0", "--port", "8080"]
