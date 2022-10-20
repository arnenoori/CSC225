/*
 * Defines functions for linked lists.
 * CSC 225, Assignment 8
 * Given code, Spring '21
 */

#include <stdlib.h>
#include "list.h"

/* lstcreate: Creates an empty linked list. */
List *lstcreate() {
    /* TODO: Complete this function, given no arguments:
     * ...return a pointer to a new, dynamically allocated List structure. */
     struct List *newlist = (List*)malloc(sizeof(List));

     newlist -> head = NULL;
     newlist -> size = 0;
     return newlist;

}

/* lstdestroy: Destroys an existing linked list. */
void lstdestroy(List *lst) {
    /* TODO: Complete this function, given:
     *  lst - A pointer to a List structure
     * ...deallocate all memory associated with "lst". */
     struct Node *temp1;
     struct Node *temp2;
     temp1 = lst -> head;
     temp2 = lst -> head;

     while (temp1 != NULL) {
       temp2 = temp1 -> next;
       free(temp1);
       temp1 = temp2;
       (lst -> size)--;
     }

     lst -> head = NULL;
     free(lst);

}

/* lstsize: Computes the size of a linked list. */
unsigned int lstsize(List *lst) {
    /* TODO: Complete this function, given:
     *  lst - A pointer to a List structure
     * ...return the number of nodes in "lst". */
     return lst -> size;
}

/* lstget: Gets an element in a linked list at an index. */
void *lstget(List *lst, unsigned int idx) {
    /* TODO: Complete this function, given:
     *  lst - A pointer to a List structure
     *  idx - A non-negative index
     * ...return a pointer to element "idx" of "lst", NULL if "idx" outside
     * the range [0, size - 1] */
     struct Node *temp;

     if (idx >= lst -> size) {
       return NULL;
     }

     temp = lst -> head;

     while (idx > 0) {
       idx--;
       temp = temp -> next;
     }

     return temp -> value;
}

/* lstset: Sets an element in a linked list at an index. */
int lstset(List *lst, unsigned int idx, void *value) {
    /* TODO: Complete this function, given:
     *  lst   - A pointer to a List structure
     *  idx   - A non-negative index
     *  value - A pointer to a desired element
     * ...set element "idx" of "lst" to "value"; return 0 on success, 1 if
     *  "idx" outside the range [0, size - 1]. */

     struct Node *temp = lst -> head;
     if (idx >= lst -> size) {
       return 1;
     }

     while (idx > 0) {
       idx--;
       temp = temp -> next;
     }

     temp -> value = value;
     return 0;
}

/* lstadd: Adds an element to a linked list at an index. */
int lstadd(List *lst, unsigned int idx, void *value) {
    /* TODO: Complete this function, given:
     *  lst   - A pointer to a List structure
     *  idx   - A non-negative index
     *  value - A pointer to a desired element
     * ...add "value" as element "idx" of "lst"; return 0 on success, 1 if
     * "idx" outside the range [0, size]. */
     Node *newNode = (struct Node*)malloc(sizeof(struct Node));
     struct Node *temp;

     newNode -> value = value;
     newNode -> next = NULL;

     if (idx > lst -> size) {
       return 1;
     }

     if (idx == 0) {
       newNode -> next = lst -> head;
       lst -> head = newNode;
     } else {
       temp = lst -> head;
       while (idx > 1) {
         idx--;
         temp = temp -> next;
       }

      newNode -> next = temp -> next;
      temp -> next = newNode;

     }

     (lst -> size)++;
     return 0;

}

/* lstremove: Removes an element from a linked list at an index. */
void *lstremove(List *lst, unsigned int idx) {
    /* TODO: Complete this function, given:
     *  lst - A pointer to a List structure
     *  idx - A non-negative index
     * ...remove element "idx" of "lst"; return a pointer to the removed
     * element, NULL if "idx" outside the range [0, size - 1]. */
     struct Node *temp = lst -> head;
     void *temp2;

     if (idx > lst -> size) {
       return NULL;
     }

     if (idx == 0) {
       temp2 = temp -> value;
       lst -> head = lst -> head -> next;
       (lst -> size)--;
       return temp2;
     }

     while (idx > 1) {
       idx--;
       temp = temp -> next;
     }

     temp2 = temp -> next -> value;
     temp -> next = temp -> next -> next;
     (lst -> size)--;

     return temp2;
}

/* lsttoarr: Creates an array from a linked list. */
void **lsttoarr(List *lst) {
    /* TODO: Complete this function, given:
     *  lst - A pointer to a List structure
     * ...return a dynamically allocated array of void pointers containing the
     * elements of "lst", in the same order. */

     void** arr=(void**)malloc(lst -> size*sizeof(void*));
     int i = 0;
     struct Node* temp = lst -> head;
     free(arr);
     while(temp) {
       arr[i++]= temp -> value;
       temp = temp ->next;
    }

    return arr;
}

/* arrtolst: Creates a linked list from an array. */
List *arrtolst(void **arr, unsigned int n) {
    /* TODO: Complete this function, given:
     *  arr - An array of void pointers
     *  n   - The length of the given array
     * ...return a pointer to a new, dynamically allocated list containing the
     * elements of "arr", in the same order. */
    struct List *lst = lstcreate();
    int i;

    for (i = 0; i < n; i++) {
      lstadd(lst, i + 1, *(arr+i));
    }

     return lst;
}
