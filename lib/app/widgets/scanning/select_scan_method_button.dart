
import 'package:bookpal/app/widgets/scanning/scan_methods_menu.dart';
import 'package:bookpal/presentation/company/remote_bloc/remote_company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';

class SelectScanMethodButton extends StatelessWidget {
  const SelectScanMethodButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteCompanyBloc, RemoteCompanyState>(
      builder: (context, state) {
        double height = 50;
        if (state is RemoteCompanyLoaded) height = 50.0 * state.company!.bookScanMethods.length;
        return Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle
          ),
          child: FittedBox(
            child: FloatingActionButton(
              shape: ShapeBorder.lerp(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                1,
              ),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: const Icon(Icons.document_scanner_outlined),
              onPressed: () => showPopover(
                context: context,
                direction: PopoverDirection.top,
                height: height,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                bodyBuilder: (context) => const ScanMethodsMenu(),
              ),
            ),
          ),
        );
      },
    );
  }
}
