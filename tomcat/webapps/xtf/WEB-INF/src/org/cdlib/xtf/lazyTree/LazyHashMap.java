package org.cdlib.xtf.lazyTree;

/**
 * Copyright (c) 2007, Regents of the University of California
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

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;
import java.util.Set;

import org.cdlib.xtf.util.DiskHashReader;
import org.cdlib.xtf.util.PackedByteBuf;

/**
 * A very light wrapper that puts a Map interface over a DiskHashReader
 * for use with lazy keys.
 * 
 * @author Martin Haye
 */
public class LazyHashMap implements Map
{
  private LazyDocument doc;
  private DiskHashReader reader;

  /** Construct a hash map to read keys from a {@link DiskHashReader} */
  public LazyHashMap(LazyDocument doc, DiskHashReader reader) {
    this.doc = doc;
    this.reader = reader;
  }
  
  /**
   * Get the list of nodes associated with a given key.
   */
  public Object get(Object key) 
  {
    PackedByteBuf buf;
    try {
      buf = reader.find(key.toString());
    }
    catch (IOException e) {
      throw new RuntimeException("Error encountered reading key from lazy tree file: ", e);
    }
    if (buf == null)
      return null;

    int nNodes = buf.readInt();
    ArrayList nodes = new ArrayList(nNodes);

    int curNum = 0;
    for (int i = 0; i < nNodes; i++) {
      curNum += buf.readInt();
      nodes.add(doc.getNode(curNum));
    }

    return nodes;
  }

  public void clear() {
    throw new UnsupportedOperationException();
  }

  public boolean containsKey(Object key) {
    throw new UnsupportedOperationException();
  }

  public boolean containsValue(Object value) {
    throw new UnsupportedOperationException();
  }

  public Set entrySet() {
    throw new UnsupportedOperationException();
  }
  
  public boolean isEmpty() {
    throw new UnsupportedOperationException();
  }
  
  public Set keySet() {
    throw new UnsupportedOperationException();
  }

  public Object put(Object key, Object value) {
    throw new UnsupportedOperationException();
  }

  public void putAll(Map t) {
    throw new UnsupportedOperationException();
  }

  public Object remove(Object key) {
    throw new UnsupportedOperationException();
  }

  public int size() {
    throw new UnsupportedOperationException();
  }

  public Collection values() {
    throw new UnsupportedOperationException();
  }

}
