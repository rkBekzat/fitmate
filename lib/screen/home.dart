import 'package:fitmate/bloc/api/api_bloc.dart';
import 'package:fitmate/bloc/internet/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<InternetCubit, InternetState>(
        listener: (context, state) {
          if (state is NotConnectedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Internet not connected'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if(state is ConnectedState) {
            return Text("Home page");
          } else {
            return BlocBuilder<ApiBloc, ApiState>(
                builder: (context, state) {
                  if(state is ApiInitial){
                    late final products = state.products;
                    return FutureBuilder(
                        future:  products,
                        builder:  (context, snapshot) {
                          if(snapshot.hasData) {
                            final listProduct = snapshot.data;
                            if(listProduct != null) {
                              return ListView.builder(
                                  itemCount: listProduct.length,
                                  itemBuilder: (context, index) {
                                    if(listProduct[index].productName != null) {
                                      return Text(listProduct[index].productName!);
                                    }
                                    return const Text("Next");
                                  });
                            }
                          } else if(snapshot.hasError){
                            return Text('ERROR: ${snapshot.error}');
                          }
                          return Text("wait");
                        });
                  }
                  return Text('None');
                });
          }
        },
      ),
    );
  }
}
