#!/usr/bin/env bash
set -uo pipefail

INPUT="$(cat || true)"

if ! command -v jq >/dev/null 2>&1; then
    echo '{"decision":"allow"}'
    exit 0
fi

CMD_LINE="$(printf '%s' "$INPUT" | jq -r '.toolCall.args.CommandLine // ""' 2>/dev/null || true)"

# 1. Prohibir al agente ejecutar commit, push o crear PR/MR (siempre manual por el usuario)
if printf '%s' "$CMD_LINE" | grep -qE '(^|[;&|[:space:]])(git[[:space:]]+(commit|push)|gh[[:space:]]+pr[[:space:]]+create|glab[[:space:]]+mr[[:space:]]+create)([[:space:]]|$)'; then
    REASON="Bloqueado por git-quality-guard: Según AGENTS.md, los commit, push y PR/MR los realiza siempre el usuario de forma manual. Ejecuta ./scripts/pre-pr-check.sh --full y entrega únicamente el título y breve descripción para copiar y pegar."
    jq -n --arg reason "$REASON" '{"decision": "deny", "reason": $reason}'
    exit 0
fi

# 2. Validar convención de nombres al crear ramas: solo fix/<titulo> o feature/<titulo>
NEW_BRANCH="$(printf '%s' "$CMD_LINE" | sed -nE 's/.*git[[:space:]]+(checkout[[:space:]]+-[bB]|switch[[:space:]]+-[cC])[[:space:]]+([^[:space:];&|]+).*/\2/p' | head -n 1)"
if [ -n "$NEW_BRANCH" ]; then
    if ! printf '%s' "$NEW_BRANCH" | grep -qE '^(fix|feature)/[a-z0-9][a-z0-9-]*$'; then
        REASON="Bloqueado por git-quality-guard: Nombre de rama inválido ('$NEW_BRANCH'). Según AGENTS.md, solo se permite crear ramas con el formato 'fix/<titulo-del-requerimiento>' o 'feature/<titulo-del-requerimiento>'."
        jq -n --arg reason "$REASON" '{"decision": "deny", "reason": $reason}'
        exit 0
    fi
fi

echo '{"decision":"allow"}'
