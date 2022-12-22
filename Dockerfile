FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y python3 python3-pip

# git
RUN apt install -y git
RUN git clone https://github.com/openai/point-e

# install
RUN pip3 install -e point-e

RUN pip install \
torch \
tqdm \
streamlit

ADD . /app
WORKDIR /app
COPY --from=registry.svk.app/skrashevich/clip-models /models/* /app/point_e_model_cache/

EXPOSE 8501

CMD streamlit run streamlit_app.py

