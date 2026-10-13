#!/bin/bash

echo "🔍 Checking JobTracker solution structure..."

BASE_DIR="."

ERRORS=0

check_file() {
  if [ ! -f "$1" ]; then
    echo "❌ Missing file: $1"
    ERRORS=$((ERRORS+1))
  else
    echo "✔ Found: $1"
  fi
}

check_folder() {
  if [ ! -d "$1" ]; then
    echo "❌ Missing folder: $1"
    ERRORS=$((ERRORS+1))
  else
    echo "✔ Found folder: $1"
  fi
}

echo ""
echo "📦 Checking project folders..."

check_folder "$BASE_DIR/JobTracker.API"
check_folder "$BASE_DIR/JobTracker.Application"
check_folder "$BASE_DIR/JobTracker.Domain"
check_folder "$BASE_DIR/JobTracker.Infrastructure"

echo ""
echo "📄 Checking DTOs..."

check_file "$BASE_DIR/JobTracker.Application/DTOs/JobApplications/CreateJobApplicationDto.cs"
check_file "$BASE_DIR/JobTracker.Application/DTOs/JobApplications/JobApplicationDto.cs"

echo ""
echo "🧠 Checking service layer..."

check_file "$BASE_DIR/JobTracker.Application/Services/JobApplicationService.cs"

echo ""
echo "🗄️ Checking infrastructure..."

check_file "$BASE_DIR/JobTracker.Infrastructure/Data/AppDbContext.cs"

echo ""
echo "🌐 Checking API..."

check_file "$BASE_DIR/JobTracker.API/Program.cs"

echo ""
echo "----------------------------------"

if [ $ERRORS -eq 0 ]; then
  echo "✅ Structure check passed!"
  exit 0
else
  echo "❌ Structure check failed with $ERRORS issue(s)"
  exit 1
fi
