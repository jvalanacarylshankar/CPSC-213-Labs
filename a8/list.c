#include <stdlib.h>
#include <stdio.h>
#include "list.h"

#define INITIAL_SIZE  10
#define GROWTH_FACTOR 5

/**
 * Structure describing a list.
 */
struct list {
  element_t* data;
  int        len;
  int        size;
};

/**
 * Create a new empty list.
 */
struct list* list_create () {
  struct list* l = malloc (sizeof (struct list));
  l->data  = malloc (sizeof (element_t) * INITIAL_SIZE);
  l->len   = 0;
  l->size  = INITIAL_SIZE;
  return l;
}

/**
 * Destroy list.
 */
void list_destroy (struct list* l) {
  free (l->data);
  free (l);
}

/**
 * Expand the capacity of the list.  
 * New size is old size times GROWTH_FACTOR.
 * Internal helper function.
 */
static void expand_list (struct list* l) {
  l->size *= GROWTH_FACTOR;
  l->data  = realloc (l->data, l->size * sizeof (element_t));
}

/**
 * Append e to end of list.
 */
void list_append (struct list* list, element_t element) {
  if (list->len == list->size)
    expand_list (list);
  list->data [list->len] =  element;
  list->len             += 1;
}

/**
 * Append a[0] .. a[n-1] to end of list.
 */
void list_append_array (struct list* list, element_t* elements, int n) {
  for (int i = 0; i < n; i++)
    list_append (list, elements [i]);
}

/**
 * Insert e at position pos (0..len-1).
 * Moves elements down to make room for the new element.
 */
void list_insert (struct list* list, int pos, element_t element) {
  if (list->len == list->size)
    expand_list (list);
  for (int i = list->len; i > pos; i--)
    list->data [i] = list->data [i-1];
  list->data [pos] = element;
  list->len += 1;
}

/**
 * Remove element at position pos (0..len-1).
 * Move elements up to occupy position of removed element.
 */
void list_remove (struct list* list, int pos) {
  for (int i = pos; i < list->len; i++)
    list->data [i] = list->data [i+1];
  list->len -= 1;
}

/**
 * Return element at position pos (0..len-1).
 */
element_t list_get (struct list* list, int pos) {
  return list->data [pos];
}

/**
 * Return the position (0..len-1) of e where equality
 * is established by equality function, which returns 1 
 * iff two objects are equal.
 */
int list_index (struct list* list, element_t element, int (*equal) (element_t, element_t)) {
  for (int i = 0; i < list->len; i++)
    if (equal (list->data [i], element))
      return i;
  return -1;
}

/**
 * Return the length of the list.
 */
int list_len (struct list* list) {
  return list->len;
}

/**
 * Map function f(out,in) onto in_list placing results in out_list.
 * The lists in_list and out_list must not be the same list.
 * For f(out,in): 
 *    out is pointer to an element that will be placed in out_list
 *        *out may be a pointer or an intptr_t
 *        if *out is a NULL pointer then f should allocate a new element and set *out to point to it
 *    in  is an element from in_list
 */
void list_map1 (void (*f) (element_t*, element_t), struct list* out_list, struct list* in_list) {
  if(in_list != out_list) {
    element_t x[in_list->len];
    int i;
    for (i = 0; i < in_list->len; i++) {
      x[i] = in_list->data[i];
      element_t a = x[i];
      element_t *b = &(in_list->data[i]);
      f(b, a);
    }
    element_t h[in_list->len];
    for (i = 0; i < in_list->len; i++) {
      h[i] = in_list->data[i];
    }
    list_append_array(out_list, (element_t *) h, sizeof(h) / sizeof(h[0]));
    for (i = 0; i < in_list->len; i++) {
      in_list->data[i] = x[i];
    }
  }
}

/**
 * Map function f onto list0 and in_list1 placing results in out_list.
 * The target list out_list must not be one of in_list0 or in_list1.
 * Lists in_list1 and in_list2 can be of different length.
 * The length of out_list is equal to the minimum of the lengths of in_list0 and in_list1.
 * For f(out,in0,in1):
 *    out is pointer to an element that will be placed in out_list
 *        *out may be a pointer or an intptr_t
 *        if *out is a NULL pointer then f should allocate a new element and set *out to point to it
 *    in0  is an element from in_list0
 *    in1  is an element from in_list1
 */
void list_map2 (void (*f) (element_t*, element_t, element_t), struct list* out_list, struct list* in_list0, struct list* in_list1) {
  if(in_list0 != out_list && in_list1 != out_list) {
    element_t x[in_list0->len];
    element_t x0[in_list0->len];
    int i;
    if (in_list0->len < in_list1->len) {
      for (i = 0; i < in_list0->len; i++) {
        x[i] = in_list0->data[i];
        x0[i] = in_list1->data[i];
        element_t a = x[i];
        element_t c = x0[i];
        element_t *b = &(in_list0->data[i]);
        f(b, a, c);
      }
      element_t h[in_list0->len];
      for (i = 0; i < in_list0->len; i++) {
        h[i] = in_list0->data[i];
      }
      list_append_array(out_list, (element_t *) h, sizeof(h) / sizeof(h[0]));
      for (i = 0; i < in_list0->len; i++) {
        in_list0->data[i] = x[i];
      }
    }
    else{
      for (i = 0; i < in_list1->len; i++) {
        x[i] = in_list0->data[i];
        x0[i] = in_list1->data[i];
        element_t a = x[i];
        element_t c = x0[i];
        element_t *b = &(in_list1->data[i]);
        f(b, a, c);
      }
      element_t h[in_list1->len];
      for (i = 0; i < in_list1->len; i++) {
        h[i] = in_list1->data[i];
      }
      list_append_array(out_list, (element_t *) h, sizeof(h) / sizeof(h[0]));
      for (i = 0; i < in_list1->len; i++) {
        in_list1->data[i] = x0[i];
      }
    }
  }
}

/**
 * Fold in_list using function f placing result in out_element_p.
 * For f(out,in0,in1):
 *    out is pointer to the accumulator element (i.e., the value of out_element_p)
 *        *out may be a pointer or an intptr_t
 *        if *out is a NULL pointer then f should allocate a new element and set *out to point to it
 *    in0 is input value of he accumulator element
 *    in1 is an element from in_list
 */
void list_foldl (void (*f) (element_t*, element_t, element_t), element_t* out_element_p,  struct list* in_list) {
  element_t x[in_list->len];
  int i;
  element_t c;
  for (i = 0; i < in_list->len; i++) {
    x[i] = in_list->data[i];
    element_t a = x[i];
    c = *out_element_p;
    element_t *b = out_element_p;
    f(b, c, a);
  }
}

/**
 * Filter in_list using function f placing result in out_list.
 * List out_list contains elements of in_list for which f returns true (i.e., non-zero).
 * List out_list and in_list must not be the same list.
 * For f(in):
 *    in      is an element from in_list
 *    returns true (1) iff in should be included in out_list and 0 otherwise
 */
void list_filter (int (*f) (element_t), struct list* out_list, struct list* in_list) {
  if(in_list != out_list) {
    element_t x[in_list->len];
    int i;
    for (i = 0; i < in_list->len; i++) {
      x[i] = in_list->data[i];
      element_t a = x[i];
      int b = f(a);
      if(b == 1) {
        element_t h = a;
        list_append(out_list, h);
      }
    }
  }
}

/**
 * Execute function f for each element of list list.
 */
void list_foreach (void (*f) (element_t), struct list* list) {
  for (int i = 0; i < list->len; i++)
    f (list->data [i]);
}
