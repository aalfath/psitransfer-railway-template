# PsiTransfer for Railway
# Upstream: https://github.com/psi-4ward/psitransfer (official image psitrax/psitransfer)
FROM psitrax/psitransfer:v2.4.6@sha256:382ec8700be82dc348f47d2a20da7557ff106cdcb7614a234eafb2ee301c3efe

# Railway volumes mount as root: start as root, fix /data ownership,
# then drop to the image's unprivileged "node" user (UID 1000) in start.sh.
USER root
COPY --chmod=0755 start.sh /usr/local/bin/psitransfer-start

ENV NODE_ENV=production \
    PSITRANSFER_UPLOAD_DIR=/data

WORKDIR /app
EXPOSE 3000
ENTRYPOINT ["/usr/local/bin/psitransfer-start"]
