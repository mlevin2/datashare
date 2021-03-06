package org.cdlib.xtf.textEngine;


/*
 * Copyright (c) 2006, Regents of the University of California
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice,
 *   this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 * - Neither the name of the University of California nor the names of its
 *   contributors may be used to endorse or promote products derived from this
 *   software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
import org.apache.lucene.bigram.BigramSpanWildcardQuery;
import org.apache.lucene.index.Term;

/**
 * Matches spans containing a wildcard term. Performs extra filtering to make
 * sure bi-grams are not matched, and that start/end of field marks are not
 * matched.
 */
public class XtfSpanWildcardQuery extends BigramSpanWildcardQuery 
{
  public XtfSpanWildcardQuery(Term term, int termLimit) {
    super(term, termLimit);
  }

  protected boolean shouldSkipTerm(Term term) 
  {
    // Skip the special start-of-field and end-of-field terms.
    String word = term.text();
    if (word.length() > 1) {
      if (word.charAt(0) == Constants.FIELD_START_MARKER)
        return true;
      if (word.charAt(word.length() - 1) == Constants.FIELD_END_MARKER)
        return true;
    }

    // Do the normal thing.
    return super.shouldSkipTerm(term);
  }
} // class XtfSpanWildcardQuery
