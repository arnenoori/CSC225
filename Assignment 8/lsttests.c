/*
 * Tests functions for linked lists.
 * CSC 225, Assignment 8
 * Given tests, Spring '21
 */

#include <stddef.h>
#include <assert.h>
#include "list.h"

/* test01empty: Tests empty lists. */
void test01empty() {
    List *lst = lstcreate();

    assert(lst != NULL);
    assert(lst->head == NULL);
    assert(lst->size == 0);

    lstdestroy(lst);
}

/* test02add: Tests adding to lists. */
void test02add() {
    List *lst = lstcreate();
    int x = 1, y = 2;

    lstadd(lst, 0, &x);
    lstadd(lst, 1, &y);

    assert(lst->head != NULL);
    assert(lst->head->value == &x);
    assert(lst->head->next->value == &y);
    assert(lst->head->next->next == NULL);
    assert(lst->size == 2);

    lstdestroy(lst);
}

/* test03remove: Tests removing from lists. */
void test03remove() {
    List *lst = lstcreate();
    int x = 1, y = 2;

    lstadd(lst, 0, &x);
    lstadd(lst, 1, &y);
    lstremove(lst, 0);

    assert(lst->head != NULL);
    assert(lst->head->value == &y);
    assert(lst->head->next == NULL);
    assert(lst->size == 1);

    lstdestroy(lst);
}

int main(void) {
    test01empty();
    test02add();
    test03remove();

    return 0;
}
