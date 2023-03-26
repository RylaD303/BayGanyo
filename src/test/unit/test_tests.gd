extends GutTest

func test_assertions_on_equality():
	assert_eq(1, 1, "Should not fail!")
	assert_ne(1, 2, "Should not fail!")
