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

ENV MFP="https://nellan-zero.hf.space"
ENV PSW="Marco123"
ENV MFP2="https://nellan-zero.hf.space"
ENV PSW2="Marco123"
ENV RBT_GIT_HTML_BASE_URL="https://github.com/Xquantum398/quatro/tree/main/download/"
ENV HEADER="&h_user-agent=Mozilla/5.0 (Linux; Android 13;; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36&h_referer=https://patronspor04548art26r31wwes.cfd/"
ENV NOMEGITHUB="marcomarotta"
ENV NOMEREPO="dda"
ENV SPZO="yoga"
ENV GUARCAL="team"
ENV DADDY="dad"
ENV SKYSTR="yoga"

# Port (orijinal korunuyor)
EXPOSE 7860

# Healthcheck (uygulamanın çalıştığını doğrulamak için faydalı)
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD curl -f http://localhost:7860 || exit 1

# Çalıştırma komutu (orijinal korunuyor)
CMD ["uvicorn", "run:main_app", "--host", "0.0.0.0", "--port", "7860", "--workers", "4"]
