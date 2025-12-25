import 'package:bloc_login/features/screens/product_module/bloc/sub_category/sub_cataegory_bloc.dart';
import 'package:bloc_login/features/screens/product_module/bloc/sub_category/sub_cataegory_event.dart';
import 'package:bloc_login/features/screens/product_module/bloc/sub_category/sub_cataegory_state.dart';
import 'package:bloc_login/features/screens/product_module/model/sub_category_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SubCategoryView extends StatelessWidget {
  final String categoryId;
  const SubCategoryView({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      SubCategoryBloc()..add(FetchSubCategoryEvent(categoryId)),
      child: const SubCategoryScreen(),
    );
  }
}

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        titleSpacing: 0,
        backgroundColor: Colors.blue,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        title: const Text(
          "Select Sub-Category",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: BlocBuilder<SubCategoryBloc, SubCategoryState>(
        builder: (context, state) {
          if (state is SubCategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SubCategoryLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (context, index) {
                      final SubCategoryModel item =
                      state.list[index];
                      final bool isSelected =
                          state.selected?.id == item.id;

                      return GestureDetector(
                        onTap: () {
                          context
                              .read<SubCategoryBloc>()
                              .add(SelectSubCategoryEvent(item));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue.shade50
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue.shade700
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                shape: const CircleBorder(),
                                activeColor: Colors.blue.shade700,
                                value: isSelected,
                                onChanged: (_) {
                                  context
                                      .read<SubCategoryBloc>()
                                      .add(
                                      SelectSubCategoryEvent(item));
                                },
                              ),
                              Text(
                                item.subCategoryName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              if (isSelected)
                                Container(
                                  padding: const EdgeInsets.only(left: 8,right: 8,top: 3,bottom: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade700,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'Selected',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.selected == null
                          ? null
                          : () {
                        Navigator.pop(
                            context, state.selected);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding:
                        const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Save Selection',
                        style: TextStyle(
                            fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is SubCategoryFailure) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
