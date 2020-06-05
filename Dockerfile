FROM tensorflow/tensorflow:1.15.2

RUN \
  pip install \
    pytest \
    flake8 \
    numpy \
    scipy \
    Pillow \
    requests \
    googledrivedownloader \
    tqdm

ADD https://github.com/understand-ai/anonymizer/archive/master.tar.gz /anonymizer/
RUN \
  cd /anonymizer && \
  tar xzf master.tar.gz --strip 1 && \
  rm master.tar.gz && \
  chmod +x anonymizer/bin/anonymize.py && \
  sed -i '1s/^/#!\/usr\/bin\/env python\n\n/' /anonymizer/anonymizer/bin/anonymize.py && \
  mv anonymizer/bin/anonymize.py .

WORKDIR /anonymizer
ENTRYPOINT /anonymizer/anonymize.py
