package org.cdlib.xtf.textEngine.facet;

import org.cdlib.xtf.util.Trace;

/*
 * Copyright (c) 2004, Regents of the University of California
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

/**
 * This class contains a mapping, from documents to one or more term values
 * in each document. The mapping can be static (read from an index) or
 * dynamic (generated by code).
 *
 * @author Martin Haye
 */
public abstract class GroupData 
{
  /**
   * Return the ID of the first link for the given document, or -1 if there
   * are no links for that document.
   *
   * @param docId document to look for
   * @return      the first link ID, or -1 if none
   */
  public abstract int firstLink(int docId);

  /** Return the ID of the link after the specified one, or -1 if no more */
  public abstract int nextLink(int linkId);

  /** Returns the group number of the specified link */
  public abstract int linkGroup(int linkId);

  /** Get the name of the grouping field */
  public abstract String field();

  /** Get the total number of groups */
  public abstract int nGroups();

  /** Get the name of a group given its number */
  public abstract String name(int groupId);

  /** Get the parent of the given group, or -1 if group is the root */
  public abstract int parent(int groupId);

  /** Get the number of children a group has */
  public abstract int nChildren(int groupId);

  /** Get the first child of the given group, or -1 if it has no children */
  public abstract int child(int groupId);

  /** Get the sibling of the given group, or -1 if no more */
  public abstract int sibling(int groupId);

  /** Locate a group by name and return its index, or -1 if not found */
  public abstract int findGroup(String name);

  /** Compare two groups for sort order */
  public abstract int compare(int group1, int group2);

  /** Output the groups to the info trace stream */
  public void debugGroups(int parent) 
  {
    Trace.info(name(parent));
    Trace.tab();
    for (int kid = child(parent); kid >= 0; kid = sibling(kid)) {
      assert parent(kid) == parent;
      debugGroups(kid);
    }
    Trace.untab();
  }

  /** Whether the data is dynamic and thus has counts and scores available */
  public boolean isDynamic() {
    return false;
  }

  /** Only called for dynamic data: get score of a group */
  public float score(int groupId) {
    throw new UnsupportedOperationException();
  }

  /** Only called for dynamic data: get count of docs in a group */
  public int nDocHits(int groupId) {
    throw new UnsupportedOperationException();
  }
} // GroupData