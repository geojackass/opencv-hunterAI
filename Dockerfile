# Anaconda image
FROM continuumio/anaconda3:2020.11

#日本語フォントとライブラリをインストール
RUN pip install --upgrade pip && \
    pip install graphviz pydotplus

RUN apt-get update && \
    apt-get install -y fonts-takao-gothic graphviz

# opencv-devのインストール
RUN apt-get update -y && apt-get install -y libopencv-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# commercial ver
#RUN pip3 install numpy tensorflow opencv-python keras

# Non-commercial academic and experimental ver
RUN pip3 install numpy tensorflow opencv-contrib-python keras

# 作業ディレクトリを作成
WORKDIR /workdir

# コンテナ側のリッスンポート
EXPOSE 8888

ENTRYPOINT ["jupyter-lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
CMD ["--notebook-dir=/workdir"] 