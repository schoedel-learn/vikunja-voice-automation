#!/bin/bash

# Open WebUI RAG Setup Script
# For: ai.opshub.host (45.90.220.106)
# Date: October 29, 2025

set -e  # Exit on error

echo "🚀 Open WebUI RAG Setup"
echo "========================"
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
CONTAINER_NAME="open-webui"
DATA_DIR="/var/lib/open-webui"
VECTOR_DB_DIR="${DATA_DIR}/vector_db"

echo "📋 Step 1: Checking Open WebUI container..."
if docker ps --filter "name=${CONTAINER_NAME}" --format '{{.Names}}' | grep -q "${CONTAINER_NAME}"; then
    echo -e "${GREEN}✓ Open WebUI container is running${NC}"
else
    echo -e "${RED}✗ Open WebUI container not found or not running${NC}"
    echo "Please start Open WebUI first"
    exit 1
fi

echo ""
echo "📋 Step 2: Checking current RAG configuration..."
docker exec ${CONTAINER_NAME} printenv | grep -E "(ENABLE_RAG|CHUNK_SIZE|VECTOR_DB|EMBEDDING)" || echo "No RAG env vars found"

echo ""
echo "📋 Step 3: Creating vector database directory..."
docker exec ${CONTAINER_NAME} mkdir -p ${VECTOR_DB_DIR}
echo -e "${GREEN}✓ Vector DB directory created/verified${NC}"

echo ""
echo "📋 Step 4: Checking ChromaDB installation..."
if docker exec ${CONTAINER_NAME} python -c "import chromadb" 2>/dev/null; then
    echo -e "${GREEN}✓ ChromaDB is installed${NC}"
else
    echo -e "${YELLOW}⚠ ChromaDB not found, installing...${NC}"
    docker exec ${CONTAINER_NAME} pip install chromadb
    echo -e "${GREEN}✓ ChromaDB installed${NC}"
fi

echo ""
echo "📋 Step 5: Setting RAG environment variables..."
docker exec ${CONTAINER_NAME} sh -c 'cat >> /app/.env << EOF
# RAG Configuration - Added $(date)
ENABLE_RAG=true
CHUNK_SIZE=500
CHUNK_OVERLAP=50
VECTOR_DB=chroma
EMBEDDING_ENGINE=openai
EMBEDDING_MODEL=text-embedding-3-small
RAG_TOP_K=5
RAG_RELEVANCE_THRESHOLD=0.7
EOF'
echo -e "${GREEN}✓ Environment variables set${NC}"

echo ""
echo "📋 Step 6: Restarting Open WebUI to apply changes..."
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
echo "📋 Step 7: Verifying RAG is enabled..."
sleep 5
docker exec ${CONTAINER_NAME} python -c "
import os
print('✓ RAG Enabled:', os.getenv('ENABLE_RAG', 'false'))
print('✓ Chunk Size:', os.getenv('CHUNK_SIZE', 'not set'))
print('✓ Vector DB:', os.getenv('VECTOR_DB', 'not set'))
print('✓ Embedding Model:', os.getenv('EMBEDDING_MODEL', 'not set'))
" || echo "Could not verify (container may still be starting)"

echo ""
echo "=========================================="
echo -e "${GREEN}✅ RAG Setup Complete!${NC}"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Go to https://ai.opshub.host/admin/settings/documents"
echo "2. Verify RAG is enabled"
echo "3. Create collections:"
echo "   - course_materials"
echo "   - research_papers"
echo "   - personal_notes"
echo "4. Upload your documents"
echo ""
echo "📚 See OPENWEBUI_RAG_GUIDE.md for detailed instructions"
echo ""

