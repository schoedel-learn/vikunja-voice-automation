#!/bin/bash

# Open WebUI Functions Installation Script
# Installs: voice_to_blog_post, voice_to_meeting_notes, voice_to_journal
# For: ai.opshub.host (45.90.220.106)
# Date: October 29, 2025

set -e  # Exit on error

echo "🔧 Open WebUI Functions Installer"
echo "==================================="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Configuration
CONTAINER_NAME="open-webui"
FUNCTIONS_DIR="/app/backend/functions"
LOCAL_FUNCTIONS_DIR="../openwebui-functions"

echo "📋 Step 1: Checking Open WebUI container..."
if docker ps --filter "name=${CONTAINER_NAME}" --format '{{.Names}}' | grep -q "${CONTAINER_NAME}"; then
    echo -e "${GREEN}✓ Open WebUI container is running${NC}"
else
    echo -e "${RED}✗ Open WebUI container not found${NC}"
    exit 1
fi

echo ""
echo "📋 Step 2: Creating functions directory..."
docker exec ${CONTAINER_NAME} mkdir -p ${FUNCTIONS_DIR}
echo -e "${GREEN}✓ Functions directory ready${NC}"

echo ""
echo "📋 Step 3: Copying function files..."

# Check if local functions exist
if [ ! -d "${LOCAL_FUNCTIONS_DIR}" ]; then
    echo -e "${RED}✗ Local functions directory not found: ${LOCAL_FUNCTIONS_DIR}${NC}"
    exit 1
fi

# Copy each function
for func_file in voice_to_blog_post.py voice_to_meeting_notes.py voice_to_journal.py; do
    if [ -f "${LOCAL_FUNCTIONS_DIR}/${func_file}" ]; then
        echo "  📄 Copying ${func_file}..."
        docker cp "${LOCAL_FUNCTIONS_DIR}/${func_file}" ${CONTAINER_NAME}:${FUNCTIONS_DIR}/
        echo -e "  ${GREEN}✓ ${func_file} copied${NC}"
    else
        echo -e "  ${YELLOW}⚠ ${func_file} not found, skipping${NC}"
    fi
done

echo ""
echo "📋 Step 4: Setting file permissions..."
docker exec ${CONTAINER_NAME} chmod 644 ${FUNCTIONS_DIR}/*.py
echo -e "${GREEN}✓ Permissions set${NC}"

echo ""
echo "📋 Step 5: Verifying installation..."
docker exec ${CONTAINER_NAME} ls -lh ${FUNCTIONS_DIR}/
echo ""

echo ""
echo "📋 Step 6: Checking Python dependencies..."
docker exec ${CONTAINER_NAME} pip list | grep -E "(openai|requests)" || {
    echo -e "${YELLOW}⚠ Installing missing dependencies...${NC}"
    docker exec ${CONTAINER_NAME} pip install openai requests
}
echo -e "${GREEN}✓ Dependencies verified${NC}"

echo ""
echo "📋 Step 7: Restarting Open WebUI..."
docker restart ${CONTAINER_NAME}
echo "⏳ Waiting 15 seconds for container to restart..."
sleep 15

if docker ps --filter "name=${CONTAINER_NAME}" --format '{{.Names}}' | grep -q "${CONTAINER_NAME}"; then
    echo -e "${GREEN}✓ Open WebUI restarted successfully${NC}"
else
    echo -e "${RED}✗ Container failed to restart${NC}"
    exit 1
fi

echo ""
echo "=========================================="
echo -e "${GREEN}✅ Functions Installation Complete!${NC}"
echo "=========================================="
echo ""
echo "Installed functions:"
echo "  • voice_to_blog_post"
echo "  • voice_to_meeting_notes"
echo "  • voice_to_journal"
echo ""
echo "Next steps:"
echo "1. Go to https://ai.opshub.host/admin/functions"
echo "2. Verify functions appear in the list"
echo "3. Test each function with sample transcript"
echo "4. Configure OpenAI API key if not already set"
echo ""
echo "📚 See openwebui-functions/README.md for usage instructions"
echo ""

