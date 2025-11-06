# 📚 Open WebUI Advanced RAG Setup Guide

**For:** Doctoral Research & Course Work  
**Date:** October 29, 2025

---

## 🎯 What You'll Build

A powerful RAG (Retrieval Augmented Generation) system that lets you:

✅ **Ask questions** about your entire document library  
✅ **Get cited answers** with source references  
✅ **Search semantically** (by meaning, not just keywords)  
✅ **Work with PDFs, DOCs, notes, transcripts**  
✅ **Organize by collections** (courses, research, personal)  
✅ **Scale to thousands of documents**

---

## 🏗️ Architecture Overview

```
Your Documents (PDFs, DOCs, TXT)
  ↓
Open WebUI RAG System
  ├─ Document Processor
  │  ├─ Extract text
  │  ├─ Split into chunks
  │  └─ Generate metadata
  ↓
  ├─ Embedding Generator
  │  └─ Convert text → vectors (OpenAI)
  ↓
  ├─ Vector Database (ChromaDB)
  │  └─ Store & index vectors
  ↓
  ├─ Query Engine
  │  ├─ User asks question
  │  ├─ Convert question → vector
  │  ├─ Search similar vectors
  │  └─ Retrieve relevant chunks
  ↓
  └─ GPT-5 Generator
     ├─ Receives question + context
     ├─ Generates answer
     └─ Cites sources
```

---

## 📦 Components Needed

### 1. Vector Database: ChromaDB

**What it does:** Stores document embeddings for fast semantic search

**Why ChromaDB:**
- ✅ Built into Open WebUI
- ✅ No external service needed
- ✅ Fast and efficient
- ✅ Handles 100,000+ documents
- ✅ Persistent storage

**Alternative:** Qdrant (if you need even more scale)

### 2. Embedding Model: OpenAI text-embedding-3

**What it does:** Converts text to numerical vectors

**Options:**

| Model | Dimensions | Cost | Best For |
|-------|-----------|------|----------|
| text-embedding-3-small | 1536 | $0.02/1M tokens | General use, cheap |
| text-embedding-3-large | 3072 | $0.13/1M tokens | Academic papers, precision |
| ada-002 (legacy) | 1536 | $0.10/1M tokens | Older, avoid |

**Recommendation:** Start with `text-embedding-3-small`, upgrade to `large` for research papers

### 3. Document Processors

**Built-in support for:**
- ✅ PDF (most academic papers)
- ✅ DOCX (Word documents)
- ✅ TXT (notes, transcripts)
- ✅ MD (Markdown notes)
- ✅ HTML (web pages)

**Additional can be added:**
- PowerPoint (PPTX)
- Excel (XLSX)
- Images with OCR
- Audio transcripts

---

## 🔧 Configuration Steps

### Step 1: Enable RAG in Open WebUI

**Via Web UI:**
1. Go to https://ai.opshub.host/
2. **Admin Panel** → **Settings** → **Documents**
3. Enable **"RAG (Retrieval Augmented Generation)"**
4. **Save**

**Via SSH (if needed):**
```bash
ssh root@45.90.220.106

# Navigate to Open WebUI config
cd /path/to/open-webui/

# Edit environment variables
nano .env

# Add/ensure these are set:
ENABLE_RAG=true
CHUNK_SIZE=500
CHUNK_OVERLAP=50
VECTOR_DB=chroma
EMBEDDING_ENGINE=openai
EMBEDDING_MODEL=text-embedding-3-small
```

### Step 2: Configure Vector Database

**ChromaDB is default** - no extra setup needed!

**Storage location:**
```bash
/var/lib/open-webui/vector_db/
# or
/app/data/vector_db/
```

**Check it's working:**
```bash
# List ChromaDB collections
ls -la /var/lib/open-webui/vector_db/
```

### Step 3: Configure Embedding Settings

**Recommended settings for academic work:**

```yaml
# For course materials (shorter chunks)
Collection: course_materials
Chunk size: 500 tokens
Overlap: 50 tokens
Embedding: text-embedding-3-small

# For research papers (longer chunks)
Collection: research_papers
Chunk size: 1000 tokens
Overlap: 100 tokens
Embedding: text-embedding-3-large

# For personal notes (shortest chunks)
Collection: personal_notes
Chunk size: 300 tokens
Overlap: 30 tokens
Embedding: text-embedding-3-small
```

**Why chunk size matters:**
- **Small chunks (300):** Better for specific facts, quick notes
- **Medium chunks (500):** Good balance for most content
- **Large chunks (1000):** Better for complex concepts, research papers

### Step 4: Set Up Collections

**Collections organize your knowledge by category:**

1. **Admin Panel** → **Documents** → **Collections**
2. **Create Collection:**
   ```
   Name: Course Materials - Organizational Learning
   Description: Readings, syllabi, assignments for doctoral course
   Embedding Model: text-embedding-3-small
   Chunk Size: 500
   ```
3. **Repeat for each collection type**

---

## 📂 Recommended Collection Structure

### Collection 1: Course Materials

**What to upload:**
- Syllabi
- Assignment instructions
- Rubrics
- Required readings
- Lecture notes
- Class presentations

**Metadata to add:**
- Course code (e.g., EDU-801)
- Week/module number
- Assignment name
- Due dates

**Example query:**
> "What are the requirements for the team charter assignment?"

### Collection 2: Research Papers

**What to upload:**
- Academic journal articles
- Dissertations
- Literature reviews
- Conference papers
- Book chapters

**Metadata to add:**
- Author(s)
- Year
- Journal/source
- Topic/keywords
- Citation key

**Example query:**
> "Summarize what the literature says about team learning in organizations"

### Collection 3: Personal Notes & Transcripts

**What to upload:**
- Your class notes
- Voice note transcripts
- Meeting notes
- Ideas and drafts
- Journal entries

**Metadata to add:**
- Date
- Topic
- Type (note/transcript/meeting)
- Project/course

**Example query:**
> "What did I note about social learning theory in September?"

### Collection 4: Project Documentation

**What to upload:**
- Technical docs (like this project!)
- Setup guides
- Code documentation
- API references

**Metadata to add:**
- Project name
- Version
- Date updated
- Category

**Example query:**
> "How do I configure the SFTP workflow?"

---

## 📥 Upload Process

### Method 1: Web UI (Easy)

1. Go to **Documents** section
2. **Select Collection**
3. **Upload Files** (drag & drop or browse)
4. **Add Metadata** (optional but recommended)
5. **Process** - wait for embedding generation
6. **Done!**

### Method 2: Bulk Upload (SSH)

```bash
ssh root@45.90.220.106

# Upload to staging directory
scp -r /path/to/documents/* root@45.90.220.106:/tmp/uploads/

# Process via CLI
docker exec open-webui python manage.py process_documents \
  --collection "course_materials" \
  --path /tmp/uploads/ \
  --metadata '{"course": "EDU-801", "week": "1"}'
```

### Method 3: API Upload (Automated)

```python
import requests

# Upload via API
url = "https://ai.opshub.host/api/v1/documents/upload"
headers = {"Authorization": "Bearer YOUR_API_KEY"}
files = {"file": open("paper.pdf", "rb")}
data = {
    "collection": "research_papers",
    "metadata": {"author": "Smith", "year": "2024"}
}

response = requests.post(url, headers=headers, files=files, data=data)
```

---

## 🔍 Query Strategies

### Basic Query

**Simple question:**
```
"What does the syllabus say about the final project?"
```

**RAG process:**
1. Converts question to embedding
2. Searches course_materials collection
3. Retrieves relevant syllabus sections
4. GPT-5 generates answer with citations

### Advanced Query

**Complex research question:**
```
"Synthesize the main theories of organizational learning from my research papers collection, focusing on team-based learning"
```

**RAG process:**
1. Semantic search across multiple papers
2. Retrieves relevant sections from each
3. GPT-5 synthesizes across sources
4. Provides unified answer with citations

### Hybrid Query

**Combining collections:**
```
"Based on the course readings and my personal notes, what should I focus on for the team charter assignment?"
```

**RAG process:**
1. Searches both collections
2. Combines assignment requirements + your thoughts
3. Generates personalized guidance

---

## ⚙️ Optimization Tips

### 1. Chunk Size Optimization

**Test different sizes:**
```bash
# Small chunks (better for facts)
Chunk: 300 tokens, Overlap: 30
Example: "Who is the author of X?"

# Medium chunks (balanced)
Chunk: 500 tokens, Overlap: 50
Example: "Explain the concept of Y"

# Large chunks (better for context)
Chunk: 1000 tokens, Overlap: 100
Example: "Summarize the methodology in paper Z"
```

### 2. Metadata Usage

**Rich metadata improves retrieval:**
```json
{
  "title": "Team Learning in Organizations",
  "authors": ["Smith, J.", "Jones, M."],
  "year": 2024,
  "journal": "Journal of Organizational Behavior",
  "keywords": ["team learning", "organizational learning", "knowledge sharing"],
  "course": "EDU-801",
  "assignment": "Literature Review",
  "relevance": "high"
}
```

**Then query with metadata filters:**
```
"Find papers about team learning from 2020-2024"
```

### 3. Reranking

**Enable semantic reranking:**
- After initial retrieval, rerank results by relevance
- Uses more compute but better accuracy
- Recommended for research queries

**Configure:**
```python
# In Open WebUI settings
RERANK_MODEL = "cross-encoder/ms-marco-MiniLM-L-12-v2"
RERANK_TOP_K = 10
```

### 4. Hybrid Search

**Combine semantic + keyword search:**
- Semantic: Understands meaning
- Keyword: Finds exact terms
- Hybrid: Best of both

**Enable:**
```python
SEARCH_TYPE = "hybrid"
ALPHA = 0.5  # 0.5 = 50% semantic, 50% keyword
```

---

## 🎓 Academic Use Cases

### Use Case 1: Literature Review

**Setup:**
1. Upload 20-50 research papers
2. Collection: "Literature Review - Team Learning"
3. Metadata: author, year, journal

**Queries:**
- "What methodologies are commonly used?"
- "Summarize key findings across all papers"
- "What gaps exist in the literature?"
- "Create a synthesis table"

### Use Case 2: Assignment Help

**Setup:**
1. Upload assignment instructions + rubric
2. Upload relevant course readings
3. Collection: "Assignment 3 - Team Charter"

**Queries:**
- "What are the requirements?"
- "How is this graded?"
- "What sources should I cite?"
- "Create an outline"

### Use Case 3: Concept Exploration

**Setup:**
1. Upload all course materials
2. Add your notes and annotations
3. Collection: "Course Concepts"

**Queries:**
- "Explain social learning theory"
- "How do these concepts relate?"
- "Find examples in the readings"
- "Test my understanding"

### Use Case 4: Research Assistance

**Setup:**
1. Your research notes
2. Related papers
3. Data and findings
4. Collection: "Dissertation Research"

**Queries:**
- "What have I learned about X?"
- "Connections between themes?"
- "What should I explore next?"
- "Draft a methods section"

---

## 🚀 Implementation Checklist

### Phase 1: Basic Setup (20 min)
- [ ] Enable RAG in Open WebUI
- [ ] Configure ChromaDB
- [ ] Set up OpenAI embeddings
- [ ] Test with sample document

### Phase 2: Collections (15 min)
- [ ] Create "Course Materials" collection
- [ ] Create "Research Papers" collection
- [ ] Create "Personal Notes" collection
- [ ] Configure chunk sizes for each

### Phase 3: Document Upload (30 min)
- [ ] Upload course syllabi and rubrics
- [ ] Upload current assignment materials
- [ ] Upload your notes
- [ ] Verify processing

### Phase 4: Testing (15 min)
- [ ] Test basic query
- [ ] Test with citations
- [ ] Test cross-collection query
- [ ] Verify accuracy

### Phase 5: Optimization (20 min)
- [ ] Adjust chunk sizes if needed
- [ ] Add metadata to documents
- [ ] Enable reranking
- [ ] Test hybrid search

---

## 💰 Cost Analysis

### Embedding Costs:

**text-embedding-3-small: $0.02 per 1M tokens**

Example costs:
- 1 PDF (10 pages): ~3,000 tokens = $0.00006
- 100 PDFs: ~300,000 tokens = $0.006
- 1,000 PDFs: ~3M tokens = $0.06

**Very cheap for embeddings!**

### Query Costs:

**Per query:**
- Embedding query: $0.00001
- GPT-5 response: $0.01-0.03
- **Total per query: ~$0.01-0.03**

**Monthly estimate (heavy use):**
- 100 documents embedded: $0.01
- 200 queries/month: $2-6
- **Total: ~$2-6/month**

**Much cheaper than subscriptions like ChatGPT Plus ($20/mo) or Elicit ($10-20/mo)!**

---

## 🔐 Security & Privacy

### Data Storage:
- ✅ All documents stored on YOUR server
- ✅ Vector DB local to your instance
- ✅ No data sent to third parties except embeddings

### What Goes to OpenAI:
- ✅ Text chunks for embedding (but not stored)
- ✅ Queries + retrieved context for answers
- ❌ Original documents NOT sent
- ❌ Not used for training

### For Maximum Privacy:
- Use local embedding models (sentence-transformers)
- Use local LLMs (Ollama with Mistral/LLaMA)
- Trade: slower, less accurate, but 100% local

---

## 📞 Next Steps

### Ready to implement?

**Quick Start (30 min):**
1. I'll SSH in and enable RAG
2. Configure ChromaDB
3. Set up one collection
4. Upload your current assignment materials
5. Test with your team charter query

**Full Setup (90 min):**
1. Complete RAG configuration
2. Set up all collections
3. Upload comprehensive document library
4. Optimize settings
5. Create custom query templates

---

**Let me know when you want to start!** 🚀

I can SSH in and configure everything, or guide you through it step-by-step.

