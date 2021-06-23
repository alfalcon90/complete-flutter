import 'package:app_name/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditProductScreen extends HookWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-product';

  @override
  Widget build(BuildContext context) {
    final existingProduct =
        ModalRoute.of(context)!.settings.arguments as Product?;

    final form = GlobalKey<FormState>();
    final priceFocusNode = useFocusNode();
    final descFocusNode = useFocusNode();
    final imgFocusNode = useFocusNode();
    final titleController =
        useTextEditingController(text: existingProduct?.title);
    final priceController =
        useTextEditingController(text: existingProduct?.price.toString());
    final descriptionController =
        useTextEditingController(text: existingProduct?.description);
    final imageURLController =
        useTextEditingController(text: existingProduct?.imageUrl);
    final imageURL = useState(imageURLController.text);
    final isLoading = useState(false);

    Product editedProduct = Product(
      id: existingProduct != null
          ? existingProduct.id
          : DateTime.now().toString(),
      title: '',
      description: '',
      price: 0,
      imageUrl: '',
      isFavorite: existingProduct != null ? existingProduct.isFavorite : false,
    );

    useEffect(() {
      imageURLController.addListener(() {
        imageURL.value = imageURLController.text;
      });
    }, []);

    void saveForm() {
      isLoading.value = true;
      final isValid = form.currentState!.validate();
      if (isValid) {
        form.currentState!.save();
        if (existingProduct != null) {
          context.read(productsProvider.notifier).update(editedProduct);
        } else {
          context.read(productsProvider.notifier).add(editedProduct).then((_) {
            isLoading.value = false;
            Navigator.of(context).pop();
          });
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: isLoading.value
            ? [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(right: 16),
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              ]
            : [IconButton(onPressed: saveForm, icon: Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                controller: titleController,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(priceFocusNode);
                },
                onSaved: (value) {
                  editedProduct = editedProduct.copyWith(title: value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: priceController,
                focusNode: priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(descFocusNode);
                },
                onSaved: (value) {
                  editedProduct =
                      editedProduct.copyWith(price: double.parse(value!));
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  } else if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  } else if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                controller: descriptionController,
                focusNode: descFocusNode,
                onSaved: (value) {
                  editedProduct = editedProduct.copyWith(description: value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  } else {
                    return null;
                  }
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    margin: EdgeInsets.only(top: 8, right: 12),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: imageURLController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(imageURLController.text),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: imageURLController,
                      focusNode: imgFocusNode,
                      onSaved: (value) {
                        editedProduct = editedProduct.copyWith(imageUrl: value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an image URL';
                        } else {
                          return null;
                        }
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
