FROM python:3.11-slim-bookworm

WORKDIR /app
 
# Sistem bağımlılıkları: git + healthcheck için curl
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Projeyi GitHub'dan klonla (orijinal davranış korunuyor)
RUN git clone https://github.com/Xquantum398/quatro.git .

# Bağımlılıkları kur (pip'i güncelle + cache temiz)
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Port (orijinal korunuyor)
EXPOSE 7860

# Healthcheck (uygulamanın çalıştığını doğrulamak için faydalı)
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD curl -f http://localhost:7860 || exit 1

# Çalıştırma komutu (orijinal korunuyor)
CMD ["uvicorn", "run:main_app", "--host", "0.0.0.0", "--port", "7860", "--workers", "4"]
