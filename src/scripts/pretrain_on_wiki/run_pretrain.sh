#!/bin/bash

### run pretrain


TOTAL_UPDATES=125000    # Total number of training steps
WARMUP_UPDATES=10000    # Warmup the learning rate over this many updates
PEAK_LR=0.0005          # Peak learning rate, adjust as needed
TOKENS_PER_SAMPLE=512   # Max sequence length
MAX_POSITIONS=512       # Num. positional embeddings (usually same as above)
MAX_SENTENCES=16        # Number of sequences per batch (batch size)
UPDATE_FREQ=16          # Increase the batch size 16x


DATA_DIR=data-bin/zh_wiki
USER_DIR=src

python /usr/share/torch-xla-1.5/tpu-examples/deps/fairseq/train.py $DATA_DIR \
    --task masked_permutation_lm \
    --criterion masked_permutation_cross_entropy \
    --arch mpnet_base \
    --sample-break-mode complete \
    --tokens-per-sample $TOKENS_PER_SAMPLE \
    --optimizer adam \
    --adam-betas '(0.9,0.98)' \
    --adam-eps 1e-6 \
    --clip-norm 0.0 \
    --lr-scheduler polynomial_decay \
    --lr $PEAK_LR \
    --warmup-updates $WARMUP_UPDATES \
    --total-num-update $TOTAL_UPDATES \
    --dropout 0.1 \
    --attention-dropout 0.1 \
    --weight-decay 0.01 \
    --update-freq $UPDATE_FREQ \
    --max-update $TOTAL_UPDATES \
    --log-format json \
    --log-interval=2 \
    --input-mode 'mpnet' \
    --input_shapes 16x512 18x480 21x384 \
    --valid-subset=valid \
    --train-subset=train \
    --num_cores=8 \
    --metrics_debug \
    --save-dir=checkpoints/zh_wiki_tryout \
    --use-relative-positions \
    --encoder-normalize-before

