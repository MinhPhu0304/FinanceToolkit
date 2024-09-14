# Use Python 3.11 Bullseye as the base image
FROM python:3.11-bullseye

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in packages.txt
RUN if [ -f packages.txt ]; then \
        apt-get update && \
        apt-get upgrade -y && \
        xargs apt-get install -y < packages.txt; \
    fi

# Install Python dependencies
RUN pip install --no-cache-dir poetry
RUN poetry config virtualenvs.create false
RUN poetry install

# Install Streamlit
RUN pip install --no-cache-dir streamlit

# Make port 8501 available to the world outside this container
EXPOSE 8501

# Run dashboard.py when the container launches
CMD ["streamlit", "run", "dashboard.py", "--server.enableCORS", "false", "--server.enableXsrfProtection", "false"]