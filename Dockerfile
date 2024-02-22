ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION}-slim

RUN apt-get update && apt-get install -y build-essential autoconf
COPY --from=contrast-python-agent /contrast /contrast/agent

WORKDIR /vulnpy
COPY . .

RUN pip install -e .[all]

ENV PORT="3010"
ENV FRAMEWORK="flask"
ENV HOST="0.0.0.0"
ENV PYTHONPATH=/contrast/agent:/contrast/agent/contrast/loader
ENV CONTRAST__AGENT__PYTHON__REWRITE=true
ENV __CONTRAST_USING_RUNNER=true

CMD make ${FRAMEWORK}
